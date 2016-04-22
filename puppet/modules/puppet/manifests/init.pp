class  puppet  {
  file  {"/usr/local/bin/papply":
    source  =>  "puppet:///modules/puppet/papply.sh",
    mode    =>  "0755",
  }
  
  file  {"/usr/local/bin/pull-update":
    source  =>  "puppet:///modules/puppet/pull-update.sh",
    mode    =>  "0755",
  }
  cron  {"run-puppet":
    ensure   =>  present,
    user     =>  "root",
    command  =>  "/usr/local/bin/pull-update",
    minute   =>  "*/2",
    hour     =>  "*",
  }
}
