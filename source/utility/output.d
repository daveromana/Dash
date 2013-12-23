module utility.output;
import utility.config;
import std.stdio;

enum OutputType { Info, Warning, Error }
enum Verbosity { High, Medium, Low }

static class Output
{
static:
public:
	void initialize()
	{
		verbosity = Config.get!Verbosity( "Game.Verbosity" );
	}

	void printMessage( OutputType type, string message )
	{
		if( shouldPrint( type ) )
			writefln( "%s %s", getHeader( type ), message );
	}

	void printValue( T )( OutputType type, string varName, T value )
	{
		if( shouldPrint( type ) )
			writefln( "%s %s: %s", getHeader( type ), varName, value );
	}

private:
	Verbosity verbosity;

	string getHeader( OutputType type )
	{
		switch( type )
		{
			case OutputType.Info:
				//SetConsoleTextAttribute( hConsole, 15 );
				return "[INFO]   ";
			case OutputType.Warning:
				//SetConsoleTextAttribute( hConsole, 14 );
				return "[WARNING]";
			case OutputType.Error:
				//SetConsoleTextAttribute( hConsole, 12 );
				return "[ERROR]  ";
			default:
				return "         ";
		}
	}

	bool shouldPrint( OutputType type )
	{
		return type > verbosity;
	}
}