package com.example.lab8burrito

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.RadioButton
import android.widget.Spinner
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    var ordersummary:String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun buildBurrito(view: View) {
        val proteinID = radiogroup_protein.checkedRadioButtonId
        if (proteinID != -1) {
            var specificProteinID = -1
            val ptype = findViewById<RadioButton>(proteinID).text
            when (ptype) { // kotlin equivalent of switch statement
                // get the id of the secondary radio button
                "meat" -> specificProteinID = radiogroup_meat.checkedRadioButtonId
                "veggie" -> specificProteinID = radiogroup_veggie.checkedRadioButtonId
            }
            if (specificProteinID != -1) {
                val protein = findViewById<RadioButton>(specificProteinID).text
                // snackbarWarning("burrito w $protein") // value check

                // check rice value (spinner)
                val rice = spinner_rice.selectedItem

                // check beans value (spinner)
                val beans = spinner_beans.selectedItem

                // get checkbox extras
                var extras:MutableList<String> = ArrayList()
                if (chkbox_guacamole.isChecked) {extras.add("guacamole")}
                if (chkbox_sourcream.isChecked) {extras.add("sour cream")}
                if (chkbox_cheese.isChecked) {extras.add("cheese")}
                if (chkbox_rccsalsa.isChecked) {extras.add("roasted chili-corn salsa")}
                if (chkbox_tgcsalsa.isChecked) {extras.add("tomatillo-green chili salsa")}
                if (chkbox_trcsalsa.isChecked) {extras.add("tomatillo-red chili salsa")}
                if (chkbox_fajitaveggies.isChecked) {extras.add("fajita veggies")}
                if (chkbox_queso.isChecked) {extras.add("queso blanco")}

                var addons:String = ""
                if (extras.isNotEmpty()) {
                    when (extras.size) {
                        1 -> addons = extras.elementAt(0)
                        2 -> addons = extras.first() + " and " + extras.last()
                        in 3..8 -> for (ingredient in extras) {
                            if (ingredient == extras.last()) {
                                addons += "and $ingredient"
                            } else {
                                addons += "$ingredient, "
                            }
                        }
                    }
                    addons = " stuffed with " + addons
                }

                // double wrapped switch y/n
                var doubled:String = ""
                if (switch_dblwrap.isChecked) {
                    doubled = "double wrapped "
                }

                // fill in text view message at end of submission
                ordersummary = "Your burrito order is a $doubled$protein burrito with $rice and $beans$addons."
                updateUIState()

            }
            else {
                // no specific protein or veggie selected -- give snackbar warning
                snackbarWarning("What kind of $ptype burrito do you want?")
            }
        }
        else {
            // no protein/veggie selected -- give Snackbar warning
            snackbarWarning("No protein option selected.")
        }

    }

    fun loadMeatOps(view: View) {
        // hide veggie options, if applicable
        radiogroup_veggie.setVisibility(View.GONE)

        // show meat options
        radiogroup_meat.setVisibility(View.VISIBLE)
    }

    fun loadVeggieOps(view: View) {
        // hide meat options, if applicable
        radiogroup_meat.setVisibility(View.GONE)

        // show veggie options
        radiogroup_veggie.setVisibility(View.VISIBLE)
    }

    private fun snackbarWarning(msg:String) {
        val message = Snackbar.make(root_layout, msg, Snackbar.LENGTH_SHORT)
        message.show()
    }

    fun updateUIState() {
        // function to update or restore programmatic information
        txtview_summary.text = ordersummary

        // for nullable data, use let
        // viewID?.let { ... .set...(it) }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putString("ordersummary", ordersummary)
        //for nullable data, use let
        // viewID?.let { outState.putType("key", it) }
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
        // make sure to use same key here as defined in onSaveInstanceState putString
        ordersummary = savedInstanceState.getString("ordersummary", "")
        updateUIState()
    }

}