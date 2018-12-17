#!/bin/sed

/#!\/bin\/bash/a . install_help.sh
/^ *time/{s/time/install_app()/;}
/^ *app/{s/app=\([a-zA-Z0-9\-\.]\+\)/\1/;H;d};
/^ *echo ["']Running/d;
/^ *cd "\$app"/{d;};
0,/^ *cd/{/^ *cd/{s/^ *cd *\([A-Za-z0-9\/\$\-\."]\+\)/\1/;H;d}};


/^ *tar -xf "$app/d;
/^ *rm -rf "\$app"/d;
/^ *{ echo "Loser/d;
/^ *cd.*\/sources *&\{0,2\}$/d;
/^ *exit/{x;s/\n *\(.*\)[\n ]\+\(.*\)/install_app_nest '\1' "\2"/; };
/.*&& *$/{N;/\n{ echo /{;s/&&//;P;d};P;D;}; 

