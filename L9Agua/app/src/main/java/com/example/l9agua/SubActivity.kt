package com.example.l9agua

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.RadioButton
import kotlinx.android.synthetic.main.activity_sub.*

class SubActivity : AppCompatActivity() {

    private var mWaterBottle = WaterBottle()
    private var userInput: String? = null
    private var waterLog:Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sub)

        waterLog = intent.getIntExtra("currentQty", 0)

        btn_submitupdate.setOnContextClickListener {
            mWaterBottle.updateWaterLog(waterLog, (radioGroup_units.checkedRadioButtonId == "radio_oz")?true:false)

            val intent = Intent(this, MainActivity::class.java)
            intent.putExtra("newQty", mWaterBottle.qty)

            finish()
        }
    }

    private fun consolidateData () {
        val unitID = radioGroup_units.checkedRadioButtonId
        val unit = findViewById<RadioButton>(unitID).text
        // since ternary operator doesn't seem to be a thing in kotlin....
        var u = true
        if (unit != "radio_oz") { u = false }

        mWaterBottle.updateWaterLog(waterLog, u)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
    }

    override fun onBackPressed() {
        val data = Intent()
        data.putExtra("newQty", mWaterBottle.qty)
        setResult(Activity.RESULT_OK, data)

        super.onBackPressed()
        finish()
    }
}