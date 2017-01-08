class project::neo4j  
   {

 
require pkg::python::pip
 # package {['java-1.8.0-openjdk','java-1.8.0-openjdk-devel']: 
 #       ensure => installed,
 #   }
  

# ---------------------------------------------------------------------------- 
# Installing Neo4j Database  


   
  nci::untar { "/local/neo4j" : 
      source => "https://neo4j.com/artifact.php?name=neo4j-community-3.0.7-unix.tar.gz", 
        }
  
    #setting it web interface to listen *  
file_line { "allow web interafce on http to listen *":  
    path => "/local/neo4j/conf/neo4j.conf",      
    require => Nci::Untar['/local/neo4j'],
    ensure => present,             
    line => "dbms.connector.http.address=0.0.0.0:7474",       
    match => "#dbms.connector.http.address=0.0.0.0:7474",             
         } 
    
 file_line { "allow web interafce on https to listen *":  
    path => "/local/neo4j/conf/neo4j.conf",      
    ensure => present,             
    require => Nci::Untar['/local/neo4j'],
    line => "dbms.connector.https.address=0.0.0.0:7473",       
    match => "dbms.connector.https.address=localhost:7473",             
         } 
         
         
    exec { 'start neo4j':
   path    => '/bin:/usr/bin',
   command => "/local/neo4j/bin/neo4j start",
     onlyif          => "test ! -f /local/neo4j/bin",
 }       
     


   
    
}
