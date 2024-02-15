#!/bin/bash

duration=5
csv_file="/home/nirbhay/Desktop/script_mib.csv"
end_time=$(date -d "now + 15 minutes" +%s)

# Check if the file exists; if not, create it with a header
if [ ! -e "$csv_file" ]; then
    echo "Timestamp,oduTDMAPerformCurrentMCS,oduTDMASNRValue,oduTDMAPerformCurrentRSSI,oduTDMAPerformCurrentPER,oduTDMAPerformTxPower,oduTDMALINKRetransmissionStats,oduEthernetCRCError,oduCurrentChanInterefence,oduTDMACINRValue,oduTDMATemperatureData,oduTDMAPerformUpdatedAt,oduTDMAPerformEntryStatus,oduTDMACurrentRXRate,oduTDMATxChain,oduTDMACurrentTXRate,oduTDMAPerformReceiveMCS,oduTDMAPerformCurrentSNR" > "$csv_file"
fi

while [ $(date +%s) -lt $end_time ]; do
    current_time=$(date "+%Y-%m-%d %H:%M:%S")

    # Execute your SNMP commands here and capture the output
    oduTDMAPerformCurrentMCS=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.2.1)
    oduTDMASNRValue=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.3.1)
    oduTDMAPerformCurrentRSSI=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.4.1)
    oduTDMAPerformCurrentPER=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.5.1)
    oduTDMAPerformTxPower=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.6.1)
    oduTDMALINKRetransmissionStats=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.7.1)
    oduEthernetCRCError=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.8.1)
    oduCurrentChanInterefence=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.9.1)
    oduTDMACINRValue=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.10.1)
    oduTDMATemperatureData=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.11.1)
    oduTDMAPerformUpdatedAt=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.12.1)
    oduTDMAPerformEntryStatus=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.13.1)
    oduTDMACurrentRXRate=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.14.1)
    oduTDMATxChain=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.15.1)
    oduTDMACurrentTXRate=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.16.1)
    oduTDMAPerformReceiveMCS=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.17.1)
    oduTDMAPerformCurrentSNR=$(snmpwalk -v 2c -c gr8cligui 192.168.171.121 .1.3.6.1.4.1.3577.2.1.2.1.18.1)
    # Add other SNMP commands as needed

    #Command for only one value of SNMP
    #oduTDMAPerformCurrentMCS=$(echo "$oduTDMAPerformCurrentMCS" | awk -F" " '{print $}'

    # Append the data to the CSV file
    echo "$current_time,$oduTDMAPerformCurrentMCS,$oduTDMASNRValue,$oduTDMAPerformCurrentRSSI, $oduTDMAPerformCurrentPER, $oduTDMAPerformTxPower, $oduTDMALINKRetransmissionStats, $oduEthernetCRCError, $oduCurrentChanInterefence, $oduTDMACINRValue, $oduTDMATemperatureData, $oduTDMAPerformUpdatedAt, $oduTDMAPerformEntryStatus, $oduTDMACurrentRXRate, $oduTDMATxChain, $oduTDMACurrentTXRate, $oduTDMAPerformReceiveMCS, $oduTDMAPerformCurrentSNR " >> "$csv_file"

    sleep $duration
done

echo "Data collection completed. Check $csv_file for details."


