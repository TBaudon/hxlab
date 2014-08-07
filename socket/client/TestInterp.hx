package ;
import hscript.Expr;
import hscript.Interp;

/**
 * ...
 * @author Thomas B
 */
class TestInterp extends Interp
{

	override function get(o : Dynamic, f : String) : Dynamic {
		if (o == null) throw "property does not exist";
		return Reflect.getProperty(o, f);
	}
	
	override function set( o : Dynamic, f : String, v : Dynamic ) : Dynamic {
        if( o == null ) throw "property does not exist";
        Reflect.setProperty(o,f,v);
        return v;
    }
		
}