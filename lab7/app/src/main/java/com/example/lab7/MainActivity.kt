package com.example.lab7

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun holidayToast(view: View) {
        // get input to editHoliday
        val holiday = findViewById<EditText>(R.id.editHoliday).text

        // get TextView/label for the greeting
        val toastMsg = findViewById<TextView>(R.id.txtGreeting)

        // apply message to text view
        toastMsg.setText("Here's a toast to " + holiday)

        // add image to view
        val imgToast = findViewById<ImageView>(R.id.toastImg)
        imgToast.setImageResource(R.drawable.champagne_toast)
    }
}