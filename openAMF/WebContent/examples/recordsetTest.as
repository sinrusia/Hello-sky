
#include "NetServices.as"

pbClickHandler=function(){
	ws = gatewayConnection.getService( "org.openamf.examples.RecordSetTest", this );
	//var op=_root.operation.text;
	//var args=_root.args.text;
	//ws[op](args);
	trace(sql.text+dbURL.text+driver.text);
	ws.getData(sql.text,dbURL.text,driver.text);
}

getData_Result=function(result){
	rc = new RecordSet(["firstname", "lastname", "alias", "securitycode", "country", "pokes"]);
	rc.addItem({firstname:"Tim", lastname:"Chung", alias:"CrudDog", securitycode:"A", country:"UK", pokes:5});

	trace(result);
	var temp1=rc;
	
	
	for(var i in temp1){
	
		trace(i+" = "+temp1[i]);
		output.text+=i+" = "+result[i]+"\n";
		
		if(i=="items"){
			trace("ITEMS");
			var temp=temp1;
			for (var j in temp){
				trace(j+" = "+temp[j]);
				for(var k in temp[j]){
					trace("data?");
					trace(k+" = "+temp[j][k]);					
				}
			}
		}
	}
	
	trace(rc instanceof RecordSet);
	trace(result instanceof RecordSet);
	mydatagrid.setRecordSet(result);
	mydatagrid.refresh();	
}

NetServices.setDefaultGatewayURL( "http://localhost:8080/openamf/gateway" );

gatewayConnection = NetServices.createGatewayConnection();

