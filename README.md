CRD Rake Tasks
==============

`crd` will be a gem that will add CRD-tailored Rake tasks to any project.
It will automatically create tasks for ActionScript, JavaScript, or any
other sort of project we can think of.

The gem could also install a `crd` CLI for project generation and scaffolding.

- TODO: Gemify and host

- TODO: Flex SDK tasks

	- *`mxmlc` => compile a given spec (will be used for release swf and test suite)*
	
	- *`asdoc` => generate documentation for a project*
	
	- *`manifest` => generate source manifest*
	
	- `config` => generate custom flex-config file for a spec
	
	- *`compc` => compile a project into a swc*
	
	- `headers` => correct source file headers
	
	- `report` => run FlexPMD for a project

- TODO: JavaScript tasks

	- `compile` => compile source with Google Closure Compiler
	
	- `lint` => validate source with js-lint

- TODO: Generic code tasks

	- `decruft` => remove diff cruft from source files

- MAYBE: Add (colorized) output for tasks?