echo "making ane now"
"/Applications/Adobe Flash Builder 4.6/sdks/AIR39/bin/adt" -package -storetype PKCS12 -keystore rect.p12 -storepass 1234 -target ane com.admod.ane extension.xml -swc *.swc -platform iPhone-ARM -platformoptions platformoptions.xml -C iPhone-ARM . 
echo "shell over,please check the dir"