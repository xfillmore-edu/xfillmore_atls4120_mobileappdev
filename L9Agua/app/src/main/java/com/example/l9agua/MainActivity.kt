package com.example.l9agua

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private var waterLog = WaterBottle()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener {
            launchWebsite()
        }
    }

    fun launchWebsite () {
        var intent = Intent()
        intent.action = Intent.ACTION_VIEW
        intent.data = Uri.parse("https://experiencelife.com/article/all-about-hydration/")

        if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
        }
        else {
            Snackbar.make(root_layout, "Unable to load website", Snackbar.LENGTH_SHORT).show()
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE) && (resultCode == Acitivity.RESULT_OK)) {
            //
        }
    }
}