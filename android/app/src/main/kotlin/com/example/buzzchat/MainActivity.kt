package com.example.buzzchat

import android.os.Build
import android.Manifest
import android.content.ContentResolver
import android.content.pm.PackageManager
import android.database.Cursor
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*
import android.webkit.MimeTypeMap
import java.io.File


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.photo_gallery/media"
    private val REQUEST_CODE_PERMISSIONS = 123
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getMediaItems") {
                getMediaItems(result)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_MEDIA_IMAGES)
                != PackageManager.PERMISSION_GRANTED ||
                ContextCompat.checkSelfPermission(this, Manifest.permission.READ_MEDIA_VIDEO)
                        != PackageManager.PERMISSION_GRANTED) {
            // Request the permissions if they are not granted
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                ActivityCompat.requestPermissions(this,
                         arrayOf(Manifest.permission.READ_MEDIA_IMAGES,
                                Manifest.permission.READ_MEDIA_VIDEO),
                        REQUEST_CODE_PERMISSIONS)
            }
        } else {
            // Permissions already granted, proceed with app initialization



        }
    }

    private fun getMediaItems(result: MethodChannel.Result) {
        val mediaItems = ArrayList<HashMap<String, Any>>()
        val contentResolver: ContentResolver = contentResolver

        // Query images
        val imageUri: Uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val imageProjection = arrayOf(
            MediaStore.Images.Media.DISPLAY_NAME,
            MediaStore.Images.Media.DATA,
            MediaStore.Images.Media.SIZE,
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media.DATE_ADDED
        )


        val imageCursor: Cursor? = contentResolver.query(imageUri, imageProjection, null, null, null)
        imageCursor?.use { cursor ->
            while (cursor.moveToNext()) {
                val mediaItem = hashMapOf<String, Any>()
                mediaItem["name"] = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DISPLAY_NAME))
                mediaItem["path"] = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA))
                mediaItem["size"] = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.SIZE))
                mediaItem["category"] = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME))
                mediaItem["type"] = getFileExtension(cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)))
                mediaItem["file"] = "Image"
                mediaItem["dateAdded"] = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATE_ADDED))
                mediaItems.add(mediaItem)

            }

        }

        // Query Video files
        val videoUri: Uri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI
        val videoProjection = arrayOf(
            MediaStore.Video.Media.DISPLAY_NAME,
            MediaStore.Video.Media.DATA,
            MediaStore.Video.Media.SIZE,
            MediaStore.Video.Media.ARTIST,
            MediaStore.Video.Media.DATE_ADDED
        )


        val videoCursor: Cursor? = contentResolver.query(videoUri, videoProjection, null, null, null)
        videoCursor?.use { cursor ->
            while (cursor.moveToNext()) {
                val mediaItem = hashMapOf<String, Any>()
                mediaItem["name"] = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DISPLAY_NAME))
                mediaItem["path"] = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATA))
                mediaItem["size"] = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.SIZE))
                mediaItem["category"] = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.ARTIST))
                mediaItem["type"] = getFileExtension(cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATA)))
                mediaItem["file"] = "Video"
                mediaItem["dateAdded"] = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATE_ADDED))
                mediaItems.add(mediaItem)
            }
        }

        // Send the result back to Flutter
        result.success(mediaItems)
    }

    private fun getFileExtension(path: String): String {
        val file = File(path)
        val extension = MimeTypeMap.getFileExtensionFromUrl(file.path)
        return MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)?.split("/")?.get(1) ?: "unknown"
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CODE_PERMISSIONS) {
            var allPermissionsGranted = true
            for (result in grantResults) {
                if (result != PackageManager.PERMISSION_GRANTED) {
                    allPermissionsGranted = false
                    break
                }
            }
            if (allPermissionsGranted) {
                // Permissions granted, proceed with app initialization
                Log.d(TAG, "Permissions granted")
            } else {
                // Permissions denied, handle accordingly (e.g., show a message)
                Log.d(TAG, "Permissions denied")
                Toast.makeText(this, "Permissions denied", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
