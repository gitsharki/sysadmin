<?php

function parseLsys ($filename)
{
    $i = 0;

    if (!file_exists($filename)) {
        return false;
    }

    $handle = fopen($filename, 'r');
    echo "Hostname,Ubuntu,CPUs,Memory(MB),Total,Used,Free\n";
    while (($line = fgets($handle)) !== false ) {
        $i++;
        if ( str_starts_with($line,'lssys.sh')) {
            continue;
        } else if ( str_starts_with($line, '========') ) {
            if ( $i > 1 ) {
                echo "\n";
            }
            $pattern = "/======== (.+) =========/";
            $success = preg_match($pattern, $line, $match);
            if ( $success ) {
                $hostname = $match[1];
                echo '"' . $hostname . '",';
            }
        } else if ( str_starts_with($line, "Ubuntu") ) {
            $pattern = '/Ubuntu (.+)\\\n \\\l/';
            $success = preg_match($pattern, $line, $match);
            if ( $success ) {
                $version = $match[1];
                echo '"' . $version . '",';
            }
        } else if ( str_starts_with($line, "CPU") ) {
            $pattern = "/CPU.*(\d)+$/";
            $success = preg_match($pattern,$line,$match);
            if ( $success ) {
                $cpus = $match[1];
                echo '"' . $cpus . '",';
            }
        } else if ( str_starts_with($line, "Mem:") ) {
            $pattern = '/Mem:(\s+)(\d+)(\s+)(\d+)(\s+)(\d+)(\s+)(\d+)(\s+)(\d+)(\s+)(\d+)/';
            $success = preg_match($pattern,$line,$match);
            if ( $success ) {
                $mem = $match[2];
                echo '"' . $mem . '",';
            }
        } else if ( str_starts_with($line, "/dev/vda1")) {
            $pattern = '/vda1(\s+)([\d.]+G)(\s+)([\d.]+G)(\s+)([\d.]+G)/';
            $success = preg_match($pattern, $line, $match);
            if ( $success ) {
                $disk = '"' . $match[2] . '","' . $match[4] . '","' . $match[6] . '"';
                echo $disk;
            }
        }
    }

    echo "\n";
    fclose($handle);

    return ($i);
}

if ( count($argv) != 2 ) {
    echo "Usage: " . $argv[0] . " [lssys-report]\n";
    exit (1);
}

$file = $argv[1];

parseLsys($file);

