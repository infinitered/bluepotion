    /* 
     * The code in this .java file gets added to the Java wrapper around our Ruby class at
     * compile time. This contains a few shims to work around cases where RubyMotion is
     * currently not generating correctly typed versions of these methods. 
     *
     * http://hipbyte.myjetbrains.com/youtrack/issue/RM-724
     *
     */
    
    // calls for the Ruby wrapper
    
    private java.util.Map<java.lang.String,java.lang.String> mParams;
    private java.util.Map<java.lang.String,java.lang.String> mHeaders;

    public void setHeaders(java.util.Map<com.rubymotion.String,com.rubymotion.String> headers) {
        mHeaders = convertMap(headers);
    }

    public void setParams(java.util.Map<com.rubymotion.String,com.rubymotion.String> params) {
        mParams = convertMap(params);
    }

    /* 
     * this converts Ruby Hash objects (keyed with com.rubymotion.String objects) to HashMap
     * objects that use java.lang.String objects as keys and values, needed for Volley's
     * framework calls
     */
    private java.util.Map<java.lang.String,java.lang.String> convertMap(
        java.util.Map<com.rubymotion.String, com.rubymotion.String> map) {
        java.util.HashMap<java.lang.String,java.lang.String> newMap = 
            new java.util.HashMap<java.lang.String, java.lang.String>();
        for (java.util.Map.Entry<com.rubymotion.String,com.rubymotion.String> entry : map.entrySet()) {
            java.lang.Object value = entry.getValue();
            if (value != null) {
                newMap.put(entry.getKey().toString(), value.toString());
            }
        }
        return newMap; 
    }


    // framework calls

    @Override
    protected java.util.Map<java.lang.String,java.lang.String> getParams() throws com.android.volley.AuthFailureError {
        return mParams;
    } 

    @Override
    public java.util.Map<java.lang.String,java.lang.String> getHeaders() throws com.android.volley.AuthFailureError {
        return mHeaders;
    }
