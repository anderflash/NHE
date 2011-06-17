var db = require("mysql-native").createTCPClient();
db.auto_prepare = true;
function dump_rows(cmd)
{
	cmd.addListener('row', function(r){console.dir(r);});
}

db.auth("cemiterio_prod","root","");
dump_rows(db.query("select * from pes_pessoa"));
db.close();