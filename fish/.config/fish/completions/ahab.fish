# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_ahab_global_optspecs
	string join \n h/help V/version
end

function __fish_ahab_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_ahab_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_ahab_using_subcommand
	set -l cmd (__fish_ahab_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c ahab -n "__fish_ahab_needs_command" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_needs_command" -s V -l version -d 'Print version'
complete -c ahab -n "__fish_ahab_needs_command" -f -a "compose" -d 'Docker compose related subcommands'
complete -c ahab -n "__fish_ahab_needs_command" -f -a "django" -d 'Django related subcommands'
complete -c ahab -n "__fish_ahab_needs_command" -f -a "postgres" -d 'Postgres related subcommands'
complete -c ahab -n "__fish_ahab_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "bash" -d 'Start bash session inside container'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "build" -d 'Build containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "down" -d 'Down containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "exec" -d 'Exec command inside container'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "ps" -d 'Print services'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "rebuild" -d 'Stop, build and start containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "restart" -d 'Stop and start containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "start" -d 'Start containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "stop" -d 'Stop containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "up" -d 'Up containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and not __fish_seen_subcommand_from bash build down exec ps rebuild restart start stop up help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from bash" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from build" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from down" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from exec" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from ps" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from rebuild" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from restart" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from stop" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from up" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "bash" -d 'Start bash session inside container'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "build" -d 'Build containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "down" -d 'Down containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "exec" -d 'Exec command inside container'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "ps" -d 'Print services'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "rebuild" -d 'Stop, build and start containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "restart" -d 'Stop and start containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "start" -d 'Start containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "stop" -d 'Stop containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "up" -d 'Up containers'
complete -c ahab -n "__fish_ahab_using_subcommand compose; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "make-command" -d 'Prepare empty management command \'command\' in app \'app\''
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "makemigrations" -d 'Run Django\'s manage.py makemigrations'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "manage" -d 'Pass arguments to Django\'s manage.py'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "migrate" -d 'Run Django\'s manage.py migrate'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "shell" -d 'Run Django\'s manage.py shell'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "test" -d 'Run Django\'s manage.py test'
complete -c ahab -n "__fish_ahab_using_subcommand django; and not __fish_seen_subcommand_from make-command makemigrations manage migrate shell test help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from make-command" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from makemigrations" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from manage" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from migrate" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from shell" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from test" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "make-command" -d 'Prepare empty management command \'command\' in app \'app\''
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "makemigrations" -d 'Run Django\'s manage.py makemigrations'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "manage" -d 'Pass arguments to Django\'s manage.py'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "migrate" -d 'Run Django\'s manage.py migrate'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "shell" -d 'Run Django\'s manage.py shell'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "test" -d 'Run Django\'s manage.py test'
complete -c ahab -n "__fish_ahab_using_subcommand django; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and not __fish_seen_subcommand_from import dump help" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and not __fish_seen_subcommand_from import dump help" -f -a "import" -d 'Import dump via pg_restore'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and not __fish_seen_subcommand_from import dump help" -f -a "dump" -d 'Dump via pg_dump with format=c'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and not __fish_seen_subcommand_from import dump help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and __fish_seen_subcommand_from import" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and __fish_seen_subcommand_from dump" -s h -l help -d 'Print help'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and __fish_seen_subcommand_from help" -f -a "import" -d 'Import dump via pg_restore'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and __fish_seen_subcommand_from help" -f -a "dump" -d 'Dump via pg_dump with format=c'
complete -c ahab -n "__fish_ahab_using_subcommand postgres; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand help; and not __fish_seen_subcommand_from compose django postgres help" -f -a "compose" -d 'Docker compose related subcommands'
complete -c ahab -n "__fish_ahab_using_subcommand help; and not __fish_seen_subcommand_from compose django postgres help" -f -a "django" -d 'Django related subcommands'
complete -c ahab -n "__fish_ahab_using_subcommand help; and not __fish_seen_subcommand_from compose django postgres help" -f -a "postgres" -d 'Postgres related subcommands'
complete -c ahab -n "__fish_ahab_using_subcommand help; and not __fish_seen_subcommand_from compose django postgres help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "bash" -d 'Start bash session inside container'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "build" -d 'Build containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "down" -d 'Down containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "exec" -d 'Exec command inside container'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "ps" -d 'Print services'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "rebuild" -d 'Stop, build and start containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "restart" -d 'Stop and start containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "start" -d 'Start containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "stop" -d 'Stop containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from compose" -f -a "up" -d 'Up containers'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from django" -f -a "make-command" -d 'Prepare empty management command \'command\' in app \'app\''
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from django" -f -a "makemigrations" -d 'Run Django\'s manage.py makemigrations'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from django" -f -a "manage" -d 'Pass arguments to Django\'s manage.py'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from django" -f -a "migrate" -d 'Run Django\'s manage.py migrate'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from django" -f -a "shell" -d 'Run Django\'s manage.py shell'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from django" -f -a "test" -d 'Run Django\'s manage.py test'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from postgres" -f -a "import" -d 'Import dump via pg_restore'
complete -c ahab -n "__fish_ahab_using_subcommand help; and __fish_seen_subcommand_from postgres" -f -a "dump" -d 'Dump via pg_dump with format=c'
