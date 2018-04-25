package org.apache.cordova.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.HashMap;
import java.util.Map;
import android.util.Log;

public class RBStringInjector extends CordovaPlugin
{
    private static final Map<String, String> injectables = new HashMap<String, String>();
    static
    {
        ;
//         injectables.put("oAuthClientId", this.cordova.getActivity().getIntent().getStringExtra("oAuthClientId"));
//         injectables.put("oAuthClientSecret", this.cordova.getActivity().getIntent().getStringExtra("oAuthClientSecret"));
    }

    /**
     *
     * @param action          The action to execute.
     * @param args            The exec() arguments.
     * @param callbackContext The callback context used when calling back into JavaScript.
     * @return Boolean result
     * @throws JSONException if the JSON isn't json, I assume
     */
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException
    {
        boolean result = false;
        if (action.equals("get"))
        {
            callbackContext.success(this.get(args.getString(0)));
            result = true;
        }
        return result;  // Returning false results in a "MethodNotFound" error.
    }

    /**
     *
     * @param key the key of the injectable
     * @return the injectable
     */
    private String get(String key)
    {
        Log.w("rosterbot - stringinjector - key", key);
    
        String res = "";
        if (key.length() > 0)
        {
            if(key.equals("oAuthClientId")) {                
                res = this.cordova.getActivity().getIntent().getStringExtra("oauthclientid");
                Log.w("rosterbot - preference", key+" : "+res);
            } else if(key.equals("oAuthClientSecret")) {
                res = this.cordova.getActivity().getIntent().getStringExtra("oauthclientsecret");
                Log.w("rosterbot - preference", key+" : "+res);
            } else {
                res = injectables.get(key);
            }
            
            Log.w("rosterbot - stringinjector", key+" : "+res);
        }
        return res;
    }
}
