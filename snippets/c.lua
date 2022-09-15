---@diagnostic disable: undefined-global
return {
	-- C simple starter template
	s("sst",
		fmt([[
		#include<stdio.h>
		
		int main({})
		{{
			{}
			return 0;
		}}
		]],
		{
			c(1, { t "", t "int argc, char** argv" }),
			i(0, "// write some code...")
		})
	),
	s("libsst",
		fmt([[
		#include<stdio.h>
		#include<stdlib.h>

		int main({})
		{{
			{}
			return 0;
		}}
		]],
		{
			c(1, { t "", t "int argc, char** argv" }),
			i(0, "// write some code...")
		})
	),

	-- Main function
	s("main",
		fmt([[
		int main({})
		{{
			{}
			return 0;
		}}
		]],
		{
			c(1, { t "", t "int argc, char** argv" }),
			i(0, "// write some code...")
		})
	)
}
