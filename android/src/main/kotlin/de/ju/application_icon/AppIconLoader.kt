package de.ju.application_icon

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.AdaptiveIconDrawable
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import androidx.annotation.RequiresApi
import java.io.ByteArrayOutputStream

class AppIconLoader(private val context: Context) {

    fun hasAdaptiveIcon(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return false
        }
        val appIcon = loadApplicationDrawable()
        return appIcon is AdaptiveIconDrawable
    }

    fun loadBitmapIcon(): ByteArray? {
        val d: Drawable = context.packageManager.getApplicationIcon(context.applicationInfo)
        return drawableToBitmap(d)?.convertToByteArray()
    }


    @RequiresApi(Build.VERSION_CODES.O)
    fun loadAdaptiveIconForeground(): ByteArray? {
        val d = loadApplicationDrawable()
        if (d !is AdaptiveIconDrawable) {
            throw Exception("Icon is not a Adaptive Icon")
        }
        return drawableToBitmap(d.foreground)?.convertToByteArray()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun loadAdaptiveIconBackground(): ByteArray? {
        val d = loadApplicationDrawable()
        if (d !is AdaptiveIconDrawable) {
            throw Exception("Icon is not a Adaptive Icon")
        }
        return drawableToBitmap(d.background)?.convertToByteArray()
    }

    private fun drawableToBitmap(drawable: Drawable): Bitmap? {
        if (drawable is BitmapDrawable) {
            if (drawable.bitmap != null) {
                return drawable.bitmap
            }
        }
        // drawable is anything else for example:
        // - ColorDrawable
        // - AdaptiveIconDrawable
        // - VectorDrawable
        val bitmap = if (drawable.intrinsicWidth <= 0 || drawable.intrinsicHeight <= 0) {
            Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) // Single color bitmap will be created of 1x1 pixel
        } else {
            Bitmap.createBitmap(drawable.intrinsicWidth, drawable.intrinsicHeight, Bitmap.Config.ARGB_8888)
        }
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun loadApplicationDrawable(): Drawable{
        val appIconId = context.applicationContext.applicationInfo.icon
        return context.applicationContext.getDrawable(appIconId)
    }
}

fun Bitmap.convertToByteArray(): ByteArray {
    val stream = ByteArrayOutputStream()
    this.compress(Bitmap.CompressFormat.PNG, 90, stream)
    return stream.toByteArray()
}