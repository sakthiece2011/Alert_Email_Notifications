#!/usr/bin/ksh
###################################################################################
#                                Paysa team entries
#                      Use pursuant to company instructions
#
#
#  Script  Name:Alert_Email_Attachement.sh
#
#  Description : This script send report to Users via email who are added in the ToEmailId
#             
#
#
#  Parameters  : Need to pass the folder path where the acutal spreadsheet or file is located. needs to share.
#
#
#  Change Log
#
#  Changed By            Date           Description
#  -----------------     ---------      -----------------------------
#  Sakthivel V      2017-04-13       Initial
######################################################################################


set -x

###############Param check:#########

if [ $# -ne 1 ]
then
echo " Usage : Incorrect Paraneters Passed <  Excel folder Path > "
exit 1
fi

###############To EmailIds:#########

ToEmailId="to_email_id";
FileDir=$1

##################################################################


###################################################################################
#Step 5:- Sending mail Notification with list of jobs modified
#################################################################################

echo "Hi Team," > $FileDir/MailTextFile.txt
echo "" >> $FileDir/MailTextFile.txt

echo "Please find the attached DashBoard generated at [ `date +%c` ]".  >> $FileDir/MailTextFile.txt
echo "" >> $FileDir/MailTextFile.txt
echo "" >> $FileDir/MailTextFile.txt
echo "This is a System generated email. Please don't reply to the email." >> $FileDir/MailTextFile.txt
echo "" >> $FileDir/MailTextFile.txt
echo "Thanks & Regards" >> $FileDir/MailTextFile.txt
echo "Paysa IDBI Team" >> $FileDir/MailTextFile.txt
cat $FileDir/MailTextFile.txt | 
    mailx -v -a "attched_file" -s "IDBI Dashboard [ `date | awk '{print $1,$2,$3}'` ]" \
    -S smtp-use-starttls \
    -S ssl-verify=ignore \
    -S smtp-auth=login \
    -S smtp=smtp://smtp.office365.com:587 \
    -S from=from_id \
    -S smtp-auth-user=user_email_id \
    -S smtp-auth-password=pwd \
    -S nss-config-dir="/etc/pki/nssdb/" \
	to_email_id

###################################################################################
#Step 6:- Removing Temp Files
##################################################################################

rm $FileDir/MailTextFile.txt