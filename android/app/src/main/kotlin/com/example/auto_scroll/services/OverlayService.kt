package com.example.auto_scroll.services

import android.app.Service
import android.content.Intent
import android.graphics.PixelFormat
import android.os.IBinder
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.Button
import com.example.auto_scroll.MainActivity
import com.example.auto_scroll.R

class OverlayService : Service() {
    private lateinit var windowManager: WindowManager
    private lateinit var overlayView: View
    private var isOverlayShowing = false

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (!isOverlayShowing) {
            showOverlay()
        }
        return START_STICKY
    }

    private fun showOverlay() {
        val inflater = LayoutInflater.from(this)
        overlayView = inflater.inflate(R.layout.overlay_menu_layout, null)

        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
            PixelFormat.TRANSLUCENT
        )

        setupButtons()
        windowManager.addView(overlayView, params)
        isOverlayShowing = true
    }

    private fun setupButtons() {
        overlayView.findViewById<Button>(R.id.startButton)?.setOnClickListener {
            // Handle start action
        }

        overlayView.findViewById<Button>(R.id.pauseButton)?.setOnClickListener {
            // Handle pause action
        }

        overlayView.findViewById<Button>(R.id.stopButton)?.setOnClickListener {
            stopSelf()
        }

        overlayView.findViewById<Button>(R.id.settingsButton)?.setOnClickListener {
            val intent = Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            startActivity(intent)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isOverlayShowing) {
            windowManager.removeView(overlayView)
            isOverlayShowing = false
        }
    }
}
