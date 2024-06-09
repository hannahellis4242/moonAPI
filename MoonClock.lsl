// API endpoint URL
string endpoint = "http://api.farmsense.net/v1/moonphases/?d=";
float updateInterval = 900;
float age = 0.0;
string phase = "";
string moonNames = "";


requestPhase(){
    integer currentTime=llGetUnixTime();
    string url=endpoint+(string)currentTime;
    llHTTPRequest(url,[HTTP_METHOD,"GET"],"");
}

default
{
    state_entry()
    {
        llSetTimerEvent(updateInterval);
    }
    touch_start(integer n){
        requestPhase();
        llWhisper(PUBLIC_CHANNEL,"\nAge : "+(string)age+"\nPhase : "+phase+"\nMoon Name : "+moonNames);
    }
    http_response(key request_id, integer status, list metadata, string body)
    {
        // Handle the HTTP response
        if(status == 200)
        {
            list resp = llJson2List(body);
            string entry = llList2String(resp,0);
            list info = llJson2List(entry);
            age = llList2Float(info,11);
            string moonName = llList2String(info,7);
            list moonNameList = llJson2List(moonName);
            moonNames = llDumpList2String(moonNameList,", ");
            phase = llList2String(info,13);
            integer index = llList2Integer(info,11);
            llSetTexture("moon_"+(string)index,ALL_SIDES);
            llSetText(phase,<1,1,1>,1);
        }
        else
        {
            llWhisper(PUBLIC_CHANNEL,"API request failed with status " + (string)status);
        }
    }
    timer()
    {
        requestPhase();
    }
}