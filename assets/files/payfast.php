<?php
$passPhrase = '';
$data = [
    'merchant_id' => '11047142',
    'merchant_key' => 'mgprvpu0ucoye',
    'name_first'=>'Thabo',
    'name_last'=>'kola',
    'email_address'=>'thbkola@gmail.com,
    'm_payment_id'=>'001',
    'amount'=>'5.00',
    'item_name'=>'001',
    ...
];

<?php
/**
 * @param array $data
 * @param null $passPhrase
 * @return string
 */
function generateSignature($data, $passPhrase = null) {
    // Create parameter string
    $pfOutput = '';
    foreach( $data as $key => $val ) {
        if(!empty($val)) {
            $pfOutput .= $key .'='. urlencode( trim( $val ) ) .'&';
        }
    }
    // Remove last ampersand
    $getString = substr( $pfOutput, 0, -1 );
    if( $passPhrase !== null ) {
        $getString .= '&passphrase='. urlencode( trim( $passPhrase ) );
    }
    return md5( $getString );
}

function dataToString($dataArray) {
  // Create parameter string
    $pfOutput = '';
    foreach( $dataArray as $key => $val ) {
        if(!empty($val)) {
            $pfOutput .= $key .'='. urlencode( trim( $val ) ) .'&';
        }
    }
    // Remove last ampersand
    return substr( $pfOutput, 0, -1 );
}

function generatePaymentIdentifier($pfParamString, $pfProxy = null) {
    // Use cURL (if available)
    if( in_array( 'curl', get_loaded_extensions(), true ) ) {
        // Variable initialization
        $url = 'https://www.payfast.co.za/onsite/process';

        // Create default cURL object
        $ch = curl_init();

        // Set cURL options - Use curl_setopt for greater PHP compatibility
        // Base settings
        curl_setopt( $ch, CURLOPT_USERAGENT, NULL );  // Set user agent
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );      // Return output as string rather than outputting it
        curl_setopt( $ch, CURLOPT_HEADER, false );             // Don't include header in output
        curl_setopt( $ch, CURLOPT_SSL_VERIFYHOST, 2 );
        curl_setopt( $ch, CURLOPT_SSL_VERIFYPEER, true );

        // Standard settings
        curl_setopt( $ch, CURLOPT_URL, $url );
        curl_setopt( $ch, CURLOPT_POST, true );
        curl_setopt( $ch, CURLOPT_POSTFIELDS, $pfParamString );
        if( !empty( $pfProxy ) )
            curl_setopt( $ch, CURLOPT_PROXY, $pfProxy );

        // Execute cURL
        $response = curl_exec( $ch );
        curl_close( $ch );
        echo $response;
        $rsp = json_decode($response, true);
        if ($rsp['uuid']) {
            return $rsp['uuid'];
        }
    }
    return null;
}

// Generate signature (see Custom Integration -> Step 2)
$data["signature"] = generateSignature($data, $passPhrase);

// Convert the data array to a string
$pfParamString = dataToString($data);

// Generate payment identifier
$identifier = generatePaymentIdentifier($pfParamString);



<html>
<head>
    <meta name="viewport" content="width=device-width">
</head>
<center>
    <body>
    <?php
    if (isset($['paynow'])){

    $data['signature'] = generateSignature($data,$passPhrase);

    $pfParamString=dataToString($data);

    $identifier=generatePaymentIdentifier($pfParamString);

    if ($identifier!==null){
       echo <script type= "text/javascript">window.payfast_do_onsite_payment({"uuid":"'.$identifier.'"});</script>
    }
    }
    ?>
    </body>
</center>
</html