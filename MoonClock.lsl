// API endpoint URL
string endpoint = "http://api.farmsense.net/v1/moonphases/?d=";
float updateInterval = 900;

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
    }
    http_response(key request_id, integer status, list metadata, string body)
    {
        // Handle the HTTP response
        if(status == 200)
        {
            //llWhisper(PUBLIC_CHANNEL,body);
            list resp = llJson2List(body);
            string entry = llList2String(resp,0);
            list info = llJson2List(entry);
            //float age = llList2Float(info,11);
            string phase = llList2String(info,13);
            integer index = llList2Integer(info,11);
            llSetTexture("moon_"+(string)index,ALL_SIDES);
            llSetText(phase,<1,1,1>,1);
            //llWhisper(PUBLIC_CHANNEL,"age : "+(string)age+" , Phase : "+phase);
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