// ErrorView.kt
package com.mfrankland.ordo62

import androidx.activity.ComponentActivity
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.mfrankland.ordo62.ui.theme._1962LiturgicalOrdoTheme

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity

@Composable
fun PlaceholderList() {
    Surface(
        modifier = Modifier.fillMaxSize(),
        color = MaterialTheme.colorScheme.background
    ) {
        // Placeholder content or other components can be added here
    }
}

@Composable
fun ErrorView(description: String) {
    val context = LocalContext.current

    // Set the status bar color using WindowInsetsControllerCompat
    val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
    windowInsetsController?.isAppearanceLightNavigationBars = true
    windowInsetsController?.isAppearanceLightStatusBars = true
    windowInsetsController?.setSystemBarsColor(Color.Transparent.toArgb())

    DisposableEffect(context) {
        // Set the status bar color with a linear gradient
        (context as? ComponentActivity)?.window?.statusBarColor = Color.Transparent.toArgb()

        // Clean up the effect when the composable is disposed
        onDispose {
            (context as? ComponentActivity)?.window?.statusBarColor = MaterialTheme.colorScheme.primary.toArgb()
        }
    }

    Box(
        modifier = Modifier
            .height(LocalDensity.current.statusBarHeight)
            .fillMaxWidth()
            .background(
                brush = Brush.horizontalGradient(
                    colors = listOf(
                        Color.Green.copy(alpha = 0.5f),
                        Color.Blue.copy(alpha = 0.3f)
                    )
                )
            ),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = description,
            color = Color.White,
            style = MaterialTheme.typography.bodyMedium
        )
    }
}

@Preview(showBackground = true)
@Composable
fun ErrorViewPreview() {
    _1962LiturgicalOrdoTheme {
        ErrorView("Sample Error Description")
    }
}
