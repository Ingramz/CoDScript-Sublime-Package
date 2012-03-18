// Comments: two types, one-line // or multi-line block comments /* */

/*
	#include path\filename;
	includes a file. Filenames have extensions omitted. path\filename.gsc would be included.
	Folders are separated by backslash. All of the path must be in one word, may have spaces/tabs/newlines before
	and after filename until semicolon. Includes must be done before any sort of function is defined inside file.

	NOTE: #includepath\filename; is also legal.

	The word 'include' must be lowercase.
*/
#include maps\includefile;

/*
	Functions - The most important element of CoDScript.
	Must be defined on top-level of the file. Can't be defined inside another function.
	Same logic applies to outside of file - no code that is meant to be inside a function, can't be outside of it.

	Functions may accept parameters. All code must be in curly braces {}, even if function is empty, braces must
	be present.

	Order of defining functions is loose. It is possible to call functions that are defined after calling in file.

	Built in functions can be overridden! For instance in this file there will be no dvar modification done.

	Function names can't be 'return', 'undefined', 'break', 'continue', 'case', 'default', 'true', 'false', 'endon',
	'breakpoint', 'else', 'if', 'for', 'switch', 'thread', 'waittillframeend', 'while', 'wait', 'waittill',	'self',
	'level', 'game'

	If function names, when both calling and defining, aren't compeletely lowercase, they are allowed. 

	Function names may not start with a number. Function names can contain letters, numbers, underscores.
	Function names are case insensitive (when both defining or calling).
	Everything about function names applies equally to variables.

	Note that spaces between function name and parentheses or between parameter variables and commas do not matter.
	Same applies to variables in form of equals sign. a=b is same as a = b.
*/

Main(parameter, param2, param3)
{
	// Variables have automatic typing. Having if(a=b) is illegal as it doesn't return anything.
	// There are 6 data types.
	myvar = 1; // Integer
	myvar = 1.0; // Float
	myvar = true; // Boolean
	myvar = "Word"; // String
	myvar = undefined; // Undefined
	myvar = (1, 5.4, .1); // Vector (x, y, z) - accepts integers, float and boolean (casted to 0 or 1)
	myvar = (true, 1, false); // Also perfectly legal
	iprintln(myvar);
	myvar = .1; // Another way of representing float value of 0.1

	// Arithmetic
	mathvar = 10;
	mathvar = mathvar + 1; // Adding
	mathvar += 1; // Can be written like this
	mathvar++; // Or like this. Note there is no --a or ++a, because a++ does not return a value!

	mathvar = mathvar - 1; // Subtracting
	mathvar -= 1;
	mathvar -- ; // can also have whitespaces, newlines inbetween operator

	mathvar = mathvar * 1; // Multiplying
	mathvar *= 1;

	mathvar = mathvar % 1; // Remainder or modulo
	mathvar %= 1;

	mathvar = mathvar / 1; // Dividing
	mathvar /= 1;

	// Bitwise operations
	mathvar = 2 | 2; // Bitwise OR
	mathvar |= 2;

	mathvar = 2 & 2; // Bitwise AND
	mathvar &= 2;

	mathvar = 2 ^ 2; // Bitwise Exclusive OR (XOR)
	mathvar ^= 2;

	// Arrays
	// An array can be defined like this:
	myarray = [];
	myarray[5] = "SomeVal";
	// Or skip definition and set a value, like this
	myarray2[3] = "Value";

	// Arrays can be associative
	myArray["hehe"] = "Hehey!";

	myArray[true] = ":)"; // Also legal

	iprintln(myarray.size); // Prints 3
	iprintln(myarray2.size); // Prints 1

	// Structs
	myStruct = spawnstruct(); // Method for creating a struct
	myStruct.property = false; // Defining a struct key with a value
	myStruct.this = 300; // Struct keys are case insensitive. Variable name restrictions still apply.
	myStruct.returN = false; // and forbid lowercase words listed above. This statement still is legal.
	myStruct thread threadedfunction("^1"); //level thread, see below.

	// File-function references
	maps\includefile::doSomething(); // Calls a function doSomething from another file.
	myvar = maps\includefile::doSomething(); // set myvar to the value returned from doSomething()
	myvar = returnten(); // sets myvar to 10

	varfun = ::returnten; // Set a function pointer
	varfun = maps\includefile::doSomething; // Function pointer from another file

	[[varfun]](); // run this function. Inside parentheses one can still have parameters.
	myvar = [[varfun]](); // Still possible to get return values.

	// An impractical example, which also works
	// Thread is a keyword that the function is to be run on background and code here will be continued immediately.
	// By default thread will run on 'level', so self == level
	thread [ [			 maps\CoDScript_example::threadedfunction ] 			] ( 	) 		;
	// The practical way to do this would be
	thread threadedfunction();

	// Vectors 2
	uno = 1;
	dos = 2;
	tres = 3;
	myvec = (uno, dos, tres);
	myvec += (tres, dos, uno); // adds together two vectors
	myvec -= (dos, dos, dos);
	myvec *= dos; // Multiplies all coordinates by 2
	myvec /= tres;
	iprintln(myvec[0]); // get the x-value

	/*
		Global objects
		There are three different objects that can occur in code.

		self, game and level

		self is an entity or a struct object that represents the entity that the code is called on.
		Depending on scenario, self can be level or a third party entity (player, radio, flag, helicopter)
		typical scenarios would be setting a value to self.
	*/
	self.somekey = "someval";
	// Running a (threaded) function
	self thread threadedfunction();

	/*
		level is a non-persistent global struct. It can't be used to store values between two game rounds. 
		game is a persistent global array which is excellent for storing data between two game rounds.
	*/

	iprintln(level.somekey); // Should print someval in this case
	level thread threadedfunction(); // level can handle functions
	game["otherkey"] = "otharval"; // when map_restart(true); is called, this will still exist

	UNDEFINED = "defined"; // Only case where undefined can be defined!
	myvar = Undefined;
	iprintln(myvar); // prints out 'defined'

	// loops
	// for loop: for(one command;condition to run (boolean);one command after a successful run)
	for(i=0;i<10;i++)
	{}

	// for(;;) is the shortest to write infinite loop.
	// while loop: while(condition). while(1) - infinite.
	a = -10;
	while(a <= 0)
		a++;

	// In loops 'continue' and 'break' work as expected

	// Note that loops and if statements can lack brackets {} for one-command statements, but for/while/if(...); is illegal

	if(a == 0)
		iprintln("This is 0");
	else if (a < 2)
	{
		iprintln("UNO");
	}
	else
	{
		iprintln("This is not right");
		a--;
	}

	/*
		Comparison operators:
			> >= < <= == !=
		Other:
			() && || !
	*/

	// Switch - accepts integer and string cases
	switch(a)
	{
		case 1:
			iprintln("Do your stuff here");
		case 2:
		case 3:
			iprintln("Do your stuff here");
			break; // can be 'continue', 'return' or omitted as above.
		default:
			iprintln("default");
			break;
	}



	setdvar("ingram", "is pro"); // This will not set a dvar.
	ReturN(); // Should call the function below, not do a return
}

threadedfunction(col)
{
	// entity variable/level/self endon("notification");
	level endon("disonnect");

	for(;;)
	{
		if(isDefined(col))
			iprintln(col+"Boing");
		else
			iprintln("Boing");
		wait 1; // many think the only correct way is wait(n); which is legal but wait n; is shorter
	}
	// entity variable/self notify("notification");
	level notify("hello");
	// entity variable/level/self waittill("notification");
	level waittill("hello");
	self endon("eternity"); // endon can be also here, typically it is still in the beginning.
}

// An example of gibberish formatting + overriding a built-in function.
setDvar  (
	a
	,
	 b
	 )


{


	iprintln

	(

		a

		+

		" : " // strings must be in one line, just like function names

		+

		b

		)

	;


}

Return()
{
	iprintln("hehey! \\\s&&1 &&2 &&3...", ":)", ":/", "&&1"); // Will output "hehey! \s:) :/ &&1..."
}

returnten()
{
	return 10;
}