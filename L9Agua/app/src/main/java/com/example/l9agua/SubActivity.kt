package com.example.l9agua

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.RadioButton
import kotlinx.android.synthetic.main.activity_sub.*

class SubActivity : AppCompatActivity() {
    private var waterLog:Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sub)

        waterLog = intent.getIntExtra("currentQty", 0)

        btn_submitupdate.setOnClickListener {
            onBackPressed() // equivalent behavior
        }
    }

    private fun consolidateData () {
        var userInput = editable_qty.text.toString().toInt()

        val unitID = radioGroup_units.checkedRadioButtonId
        val unit = findViewById<RadioButton>(unitID).text

        if (unit == "radio_oz") {
            userInput = (userInput * 29.5735).toInt()
        }

        waterLog += userInput
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
    }

    override fun onBackPressed() {
        consolidateData()

        val data = Intent()
        data.putExtra("newQty", waterLog)
        setResult(Activity.RESULT_OK, data)

        super.onBackPressed()
        finish()
    }
}