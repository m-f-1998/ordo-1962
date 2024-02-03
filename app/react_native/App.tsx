import React, {useState} from 'react';
import {
  Button,
  Dimensions,
  Image,
  Platform,
  SafeAreaView,
  StatusBar,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import WebView from 'react-native-webview';
var __html = require('./src/website/index.html');

const App = () => {
  return (
    <WebView
      source={__html}
      style={{flex: 1}}
      javaScriptEnabled={true}
      domStorageEnabled={true}
    />
    // <SafeAreaView style={styles.container}>
    //   <StatusBar
    //     barStyle="light-content"
    //     backgroundColor="transparent"
    //     translucent
    //   />
    //   <View dangerouslySetInnerHTML={template} />
    //   <Text style={styles.textStyle}>
    //     StatusBar Visibility:{'\n'}
    //     {hidden ? 'Hidden' : 'Visible'}
    //   </Text>
    //   <Text style={styles.textStyle}>
    //     StatusBar Style:{'\n'}
    //     {statusBarStyle}
    //   </Text>
    //   {Platform.OS === 'ios' ? (
    //     <Text style={styles.textStyle}>
    //       StatusBar Transition:{'\n'}
    //       {statusBarTransition}
    //     </Text>
    //   ) : null}
    //   <View style={styles.buttonsContainer}>
    //     <Button title="Toggle StatusBar" onPress={changeStatusBarVisibility} />
    //     <Button title="Change StatusBar Style" onPress={changeStatusBarStyle} />
    //     {Platform.OS === 'ios' ? (
    //       <Button
    //         title="Change StatusBar Transition"
    //         onPress={changeStatusBarTransition}
    //       />
    //     ) : null}
    //   </View>
    // </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#ECF0F1',
  },
  buttonsContainer: {
    padding: 10,
  },
  textStyle: {
    textAlign: 'center',
    marginBottom: 8,
  },
});

export default App;
