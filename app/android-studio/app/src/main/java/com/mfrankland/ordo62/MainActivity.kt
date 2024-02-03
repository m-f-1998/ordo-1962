package com.mfrankland.ordo62

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.*
import androidx.compose.runtime.*
import com.mfrankland.ordo62.ui.theme._1962LiturgicalOrdoTheme

import Server.API;
import Server.ActiveData;
import androidx.compose.ui.platform.LocalContext
import com.mfrankland.ordo62.client.services.*;
import kotlinx.coroutines.*
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState;

class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            _1962LiturgicalOrdoTheme {
                // Set up your Compose content
                OrdoAppContent();
            }
        }
    }
}

@Composable
fun OrdoAppContent() {
    // Create ViewModel instances
    val activeData = remember { mutableStateOf(ActiveData()) }
    val cont = LocalContext.current
    val api = remember { API(activeData.value, cont) }
    val networkMonitor = remember { NetworkMonitor.getInstance ( cont ) }

    // Set up the content of the app using Compose
    OrdoApp(
        activeData = activeData,
        api = api,
        net = networkMonitor
    )
}

@Composable
fun OrdoApp(
    activeData: MutableState<ActiveData>,
    api: API,
    net: NetworkMonitor
) {
    // Your Compose UI components go here
    OrdoAppUI(api = api, net = net, activeData = activeData)
}

@Composable
fun OrdoAppUI(api: API, net: NetworkMonitor, activeData: MutableState<ActiveData>) {
    val isConnected by net.isConnected.observeAsState(initial = true)
    val isLoading by activeData.value.loading.observeAsState(initial = false)
    val isError by activeData.value.error.observeAsState(initial = false)
    val isDownloading by activeData.value.downloading.observeAsState(initial = false)
//    val lastError by activeData.value.lastErr.observeAsState(initial = "")

    if (!isConnected && isDownloading) {
        Text("No Internet Connection")
//        ErrorView("No Internet Connection")
    } else if (isError) {
        Text(activeData.value.lastErr)
//        ErrorView(description = activeData.value.error.value)
    } else if (isLoading) {
        ErrorView("Loading")
//        activeData.value.setDownload(0)
//
//        LaunchedEffect(isLoading) {
//            // Ensure that the coroutine runs on the UI thread using MainDispatcher
//            withContext(Dispatchers.Main) {
//                delay(1000)
//                // Now call your suspend function or perform your logic
//                getData(api, activeData, net)
//            }
//        }

//        LoadingView().onAppear {
//            activeData.value.setDownload(0)
//            scope.launch {
//                delay(1000)
//                withContext(activeData.value.coroutineContext) {
//                    getData(api, activeData, net)
//                }
//            }
//        }
//            .environmentObject(net)
    } else {
        Text("Loaded")
//        CommonView()
//            .environmentObject(net)
    }
}

fun getData(api: API, activeData: MutableState<ActiveData>, net: NetworkMonitor) {
    if (api.cache.cacheExists()) {
        val ordo = api.cache.ordo
        if (ordo.isNotEmpty()) {
            val prayers = api.cache.prayers
            val locale = api.cache.locale
            activeData.value.setSuccess( ordo, locale, prayers)
        }
    }

    activeData.value.setStatus( false, true, true)

    try {
        api.updateCache()
    } catch (e: Exception) {
        if (net.isConnected.value == true) {
            activeData.value.setError("Ordo Update Could Not Be Fetched.")
        }
    }
}
