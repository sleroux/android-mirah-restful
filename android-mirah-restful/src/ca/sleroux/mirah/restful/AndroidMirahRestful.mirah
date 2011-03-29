# Java Imports
import java.util.Hashtable
import java.util.Vector
import java.util.ArrayList

# Android Imports
import android.app.Activity
import android.os.Bundle
import android.content.Context
import android.os.AsyncTask
import android.os.Handler
import android.os.Message
import android.widget.ArrayAdapter
import android.widget.ListView
import android.R

# Network Imports
import org.xinuc.jason.JSON
import org.apache.http.Header
import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.HttpStatus
import org.apache.http.NameValuePair
import org.apache.http.StatusLine
import org.apache.http.client.entity.UrlEncodedFormEntity
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.methods.HttpPost
import org.apache.http.client.methods.HttpRequestBase
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.message.BasicNameValuePair
import org.apache.http.protocol.HTTP

import "Layout", "ca.sleroux.mirah.restful.R$layout"

class AndroidMirahRestful < Activity 
  
  def onCreate(savedInstanceState:Bundle)
    super(savedInstanceState)
    
    # Instiantiate a handler along with a download thread to allow the trends to be 
    # fetch from a background thread
    
    handler = RefreshHandler.new
    handler.setActivity(self)
    
    task = TrendsDownloader.new
    task.setHandler(handler)
    task.start
  end
  
  # Handler for hooking into this activity's UI to update the Trends view
  class RefreshHandler < Handler
    
    # Mirah currently doesn't support constasts to be declared in a 'Java' way. Placing them
    # in the class initializer
    
    def setActivity(activity:Activity)
      @activity = activity
    end
    
    $Override
    def handleMessage(msg:Message)
      jsonTable = Hashtable(msg.obj)
      asOf = String(jsonTable.get('as_of'))
      System.out.println("Trends as of: " + asOf)
      trends = Vector(jsonTable.get('trends'))
      
      trendNames = ArrayList.new
      
      trends.each() { |trend| 
        hashTrend = Hashtable(trend)
        name = hashTrend.get('name')
        trendNames.add(name)
      }
      
      trendsView = ListView.new(@activity)
      adapter = ArrayAdapter.new(@activity, R.layout.simple_list_item_1, trendNames.toArray())
      trendsView.setAdapter(adapter)

      @activity.setContentView(trendsView)
    end
  end
  
  # Task for fetching the recent trends from Twitter
  class TrendsDownloader < Thread
    
    def setHandler(handler:Handler)
      @handler = handler
    end
    
    $Override
    def run()
      url = "http://api.twitter.com/1/trends.json"
      
      System.out.println("Fetching content from " + url)
      
      # Start up a new HTTP connection to fetch the twitter trends api
      
      httpclient = DefaultHttpClient.new
      get = HttpGet.new(url)
      get.addHeader("Accept", "application/json");
  		get.addHeader("Content-type", "application/json")
  		response = httpclient.execute(get)
  		
      status = response.getStatusLine
      statusCode = status.getStatusCode
      entity = response.getEntity
  		responseContent = entity.getContent
  		
  		# Parse the received JSON content using the jason_mirah library
  		# https://github.com/xinuc/jason_mirah
  		
  		parsedJSON = JSON.parse(responseContent)  
  		
  		# Pass off the resulting hashtable to the handler for the UI hook
  		
  		message = Message.new
  		message.obj = parsedJSON
  		@handler.sendMessage(message)
    end
  end
end
