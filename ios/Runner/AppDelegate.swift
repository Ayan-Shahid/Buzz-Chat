import UIKit
import Flutter
import Photos

struct MediaItem {
    let name: String
    let category: String
    let type: String
    let path: String
    let size: Int64
    let file: String
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example.photo_gallery/media", binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "getMediaItems" {
                self.getMediaItems { mediaItems in
                    result(mediaItems)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func getMediaItems(completion: @escaping ([[String: Any]]) -> Void) {
        var mediaItems = [[String: Any]]()
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        fetchResult.enumerateObjects { (asset, _, _) in
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            options.isNetworkAccessAllowed = true

            if asset.mediaType == .image {
                PHImageManager.default().requestImageDataAndOrientation(for: asset, options: options) { (data, _, _, info) in
                    if let data = data, let path = self.saveMediaToTemporaryDirectory(data: data, filename: asset.originalFilename) {
                        let mediaItem: [String: Any] = [
                            "name": asset.originalFilename,
                            "category": self.getAssetCollectionTitle(asset: asset),
                            "type": self.getFileType(from: asset.originalFilename),
                            "path": path,
                            "size": Int64(data.count),
                            "file": "image"
                        ]
                        mediaItems.append(mediaItem)
                    }
                }
            } else if asset.mediaType == .video {
                PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (avAsset, _, info) in
                    if let urlAsset = avAsset as? AVURLAsset {
                        let data = try? Data(contentsOf: urlAsset.url)
                        if let data = data, let path = self.saveMediaToTemporaryDirectory(data: data, filename: asset.originalFilename) {
                            let mediaItem: [String: Any] = [
                                "name": asset.originalFilename,
                                "category": self.getAssetCollectionTitle(asset: asset),
                                "type": self.getFileType(from: asset.originalFilename),
                                "path": path,
                                "size": Int64(data.count),
                                "file": "video"
                            ]
                            mediaItems.append(mediaItem)
                        }
                    }
                }
            }
        }

        // Delay the completion handler to allow async requests to finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(mediaItems)
        }
    }

    private func saveMediaToTemporaryDirectory(data: Data, filename: String) -> String? {
        let tempDir = NSTemporaryDirectory()
        let filePath = "\(tempDir)/\(filename)"
        do {
            try data.write(to: URL(fileURLWithPath: filePath))
            return filePath
        } catch {
            print("Error saving media: \(error)")
            return nil
        }
    }

    private func getAssetCollectionTitle(asset: PHAsset) -> String {
        let collections = PHAssetCollection.fetchAssetCollectionsContaining(asset, with: .album, options: nil)
        return collections.firstObject?.localizedTitle ?? "Unknown"
    }

    private func getFileType(from filename: String) -> String {
        return (filename as NSString).pathExtension.lowercased()
    }
}

extension PHAsset {
    var originalFilename: String {
        var filename = "Unknown"
        if let resource = PHAssetResource.assetResources(for: self).first {
            filename = resource.originalFilename
        }
        return filename
    }
}
