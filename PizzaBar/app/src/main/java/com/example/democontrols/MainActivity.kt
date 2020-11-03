package com.example.democontrols

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.RadioButton
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_main.* // use id's directly as variables

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun createPizza(view: View) {
        var ordermessage = "Here's the order: "
        var sauce:CharSequence = ""
        var crust:CharSequence = ""
        var toppingList = "" // String

        val sauceID = radiogroup_sauce.checkedRadioButtonId // returns ID of radio button
        val crustID = radioGroup_crust.checkedRadioButtonId

        // check for -1 (unselected) before assigning value (null pointer exception)
//        val sauce = findViewById<RadioButton>(sauceID).text
//        val crust = findViewById<RadioButton>(crustID).text
        if (crustID == -1) {
            // give snackbar warning for no selection
            // Snackbar.make(ViewByID, "Message", Snackbar.LENGTH_).show()
            val crustSnackbarWarning = Snackbar.make(root_layout, "What about crust?", Snackbar.LENGTH_SHORT)
            crustSnackbarWarning.show()
            ordermessage += "A "
        }
        else {
            crust = findViewById<RadioButton>(crustID).text // could wrap using toString() if type string
            ordermessage += "A $crust pizza "
        }
        if (sauceID == -1) {
            // give snackbar warning for no selection
            // Snackbar.make(ViewByID, "Message", Snackbar.LENGTH_).show()
            val sauceSnackbarWarning = Snackbar.make(root_layout, "What about sauce?", Snackbar.LENGTH_SHORT)
            sauceSnackbarWarning.show()
        }
        else {
            sauce = findViewById<RadioButton>(sauceID).text // could wrap using toString() if type string
            ordermessage += "with $sauce "
        }

        // Checkbox sequence
        if (checkBox.isChecked) { toppingList += " " + checkBox.text }
        if (checkBox2.isChecked) { toppingList += " " + checkBox2.text }
        if (checkBox3.isChecked) { toppingList += " " + checkBox3.text }
        if (checkBox4.isChecked) { toppingList += " " + checkBox4.text }
        if (checkBox5.isChecked) { toppingList += " " + checkBox5.text }
        if (checkBox6.isChecked) { toppingList += " " + checkBox6.text }
        if (checkBox7.isChecked) { toppingList += " " + checkBox7.text }
        if (checkBox8.isChecked) { toppingList += " " + checkBox8.text }
        if (checkBox9.isChecked) { toppingList += " " + checkBox9.text }
        if (toppingList.isNotEmpty()) { ordermessage += "with $toppingList" }

        // Kotlin conditional expression instead
        // toppinglist = (if (toppinglist.isNotEmpty()) "with $toppinglist" else "").toString()

        text_submittedorder.text = ordermessage
    }
}

// Java uses getters and setters, but Kotlin does not