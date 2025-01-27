package com.example.auto_scroll.services

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.GestureDescription
import android.graphics.Path
import android.view.accessibility.AccessibilityEvent

class CustomAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {}
    
    override fun onInterrupt() {}

    fun performClick(x: Float, y: Float) {
        val path = Path()
        path.moveTo(x, y)
        
        val gestureBuilder = GestureDescription.Builder()
        val gesture = gestureBuilder
            .addStroke(GestureDescription.StrokeDescription(path, 0, 100))
            .build()
        
        dispatchGesture(gesture, null, null)
    }
}
