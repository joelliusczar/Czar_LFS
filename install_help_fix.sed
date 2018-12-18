#!/bin/sed



/^ *\. *install_help\.sh *$/{i \\nhelper_path=${helper_path:-..}
s/^ *\. *\(install_help\.sh\) *$/. "$helper_path\/\1" /
}
