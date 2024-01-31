package com.mfrankland.ordo62

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.mfrankland.ordo62.ui.theme._1962LiturgicalOrdoTheme
import Server.API

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        // Perform the network request using coroutines
        Thread {
            try {
                val api = API(Server.ActiveData(), applicationContext)
            } catch (e: Exception) {
                // Handle network failure or any exception
                println(e)
            }
        }.start()

        super.onCreate(savedInstanceState)
        setContent {
            _1962LiturgicalOrdoTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Greeting("Android")
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    _1962LiturgicalOrdoTheme {
        Greeting("Android")
    }
}