import QtQuick.Window 2.2
import QtQuick 2.5
import QtQuick.Dialogs 1.0
import QtMultimedia 5.6
import QtWebEngine 1.0
import QtQuick.Controls 1.2

Rectangle {
    width: 640
    height: 200
    //private
    property double stopTime: -1.0;
    property double startTime: -1.0;
    property int index : 0;
    property int phase: 0
    property bool firstSetup : true;
    property bool isLoaded : false;
    property bool canContinue: true;
    property int numOfPhases: 0;
    Audio{
        id: playMusic
        source: ""
    }
    WebEngineView {
        anchors.fill: parent
        id: webView
        url: ""
        onLoadingChanged:
        {
            if(loading==false)
            {
                this.runJavaScript("numOfIds()", function(result) { numOfPhases = Number(result); });
                this.runJavaScript("startTime()", function(result)
                {
                    startTime = textToTime(result);
                    playMusic.seek(1000*startTime);
                    isLoaded = true;
                });
            }
        }
        Keys.priority: Keys.BeforeItem
    }
    /*
    myButton.text =  (playMusic.position / 1000.0) + "/" + stopTime+"("+phase+")"+ "/" + (playMusic.duration / 1000.0);
      */
    function textToTime(text)
    {
        //console.log(index+": textToTime: text="+text);
        return Number(text);
    }
    /* interface */
    function setup(textName, soundName,index_in)
    {
        console.log("setup was called");
        webView.url = textName;
        playMusic.source = soundName;
        index = index_in;
    }
    //@return: true if stay in this state, false if transition requested
    function update(state)
    {
        if(!isLoaded || !canContinue) return;
        var flag = false;
        if(state==index)
        {
            if(firstSetup)
            {
                console.log(index+": firstSetup with phase: "+phase);
                canContinue = false;
                webView.runJavaScript("cb(\""+ (phase+1) + "\")", function(result) {
                if(String(result).localeCompare("eof") != 0)
                {
                    stopTime = textToTime(result);
                    canContinue = true;
                    playMusic.play();
                }
                else
                {
                    //FIXME: we should never get in this branch
                    phase = 0;
                    canContinue = true;
                    isLoaded = true;
                    return update(state);
                }
                });
                firstSetup = false;
                return;
            }

            /*if(playMusic.playbackState!=MediaPlayer.PlayingState)
                playMusic.play();*/
            if( stopTime>0 && playMusic.position/1000.0 >= stopTime)
            {
                console.log(index+": flag=true, phase="+phase+", numOfPhases="+numOfPhases);
                playMusic.pause();
                flag = true;
                firstSetup = true;
                phase++;
                if(phase==numOfPhases)
                {
                    phase = 0;
                    playMusic.stop();
                    playMusic.seek(1000*startTime);
                }
            }
        }
        return flag;
    }
    function getPlaybackState(){return playMusic.playbackState; }
    function play(){ playMusic.play(); }
    function pause()
    {
        playMusic.pause();
    }
}
