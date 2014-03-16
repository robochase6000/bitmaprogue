package com.chasedelanguillette.geom
{
	public class GeomUtils
	{
		//---------------------------------------------------------------
		//Checks for intersection of Segment if as_seg is true.
		//Checks for intersection of Line if as_seg is false.
		//Return intersection of Segment AB and Segment EF as a Point
		//Return null if there is no intersection
		//---------------------------------------------------------------
		public static function lineIntersectLine(A:Object,B:Object,E:Object,F:Object,as_seg:Boolean=true):Object {
		    var ip:Object;
		    var a1:Number;
		    var a2:Number;
		    var b1:Number;
		    var b2:Number;
		    var c1:Number;
		    var c2:Number;

		    a1= B.y-A.y;
		    b1= A.x-B.x;
		    c1= B.x*A.y - A.x*B.y;
		    a2= F.y-E.y;
		    b2= E.x-F.x;
		    c2= F.x*E.y - E.x*F.y;

		    var denom:Number=a1*b2 - a2*b1;
		    if (denom == 0) {
		        return null;
		    }
		    ip={x:0, y:0};
		    ip.x=(b1*c2 - b2*c1)/denom;
		    ip.y=(a2*c1 - a1*c2)/denom;

		    //---------------------------------------------------
		    //Do checks to see if intersection to endpoints
		    //distance is longer than actual Segments.
		    //Return null if it is with any.
		    //---------------------------------------------------
		    if(as_seg){
		        if(Math.pow(ip.x - B.x, 2) + Math.pow(ip.y - B.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
		        {
		           return null;
		        }
		        if(Math.pow(ip.x - A.x, 2) + Math.pow(ip.y - A.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
		        {
		           return null;
		        }

		        if(Math.pow(ip.x - F.x, 2) + Math.pow(ip.y - F.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
		        {
		           return null;
		        }
		        if(Math.pow(ip.x - E.x, 2) + Math.pow(ip.y - E.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
		        {
		           return null;
		        }
		    }
		    return ip;
		}
	}
}