<?php
    // set the base url
    $url = "https://api.publicapis.org/entries";

    // Checks for command line arguments to modify the API url
    if (isset($argv[1])) {
        $url = "https://api.publicapis.org/entries?category={$argv[1]}";
    }

    // create curl resource
    $curl = curl_init($url);
    curl_setopt($curl, CURLOPT_URL, $url); // set url
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false); // dont verify SSL cert
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true); // return value as string

    // $output contains the output string
    $result = curl_exec($curl);
    
     // close curl resource
     curl_close($curl);     

     // transform to JSON
    $jsonResult = json_decode($result)->entries;

    // Checks if empty (no result) 
    if (isset($jsonResult)) {
        $mappedResult = array_map("myfunction",$jsonResult);

        // Sort in alphabetical order
        asort($mappedResult);
        // Initially limit set to max results, then check for limit passed in command line args
        $limit = count($mappedResult); 
        if (!empty($argv[2])) {
            $limit = $argv[2];
        }
        
        // Prints to string
        for($x = 0; $x < $limit; $x++) {
            print_r($mappedResult[$x]);
            print_r("\r\n");
        }

    // Value is empty
    } else {
        print_r('No results');
    }

    // Fetch relevant data from the JSON object
    function myfunction($v)
    {
        return ($v->API);
    }
  
?>