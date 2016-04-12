SSH ='ssh -A' 
desc "Run puppet on ENV['CLIENT']"
task :apply do
    client =ENV['CLIENT']
    sh "git push"
    sh "#{SSH} #{client} pull-updates"
end

desc "add syntax check hook to git repo"
task :add_check do
    here =File.dirname(__FILE__)
    sh "ln -s #{here}/hooks/check_syntax.sh #{here}/.git/hooks/pre-commit"
    puts "puppet syntax check hook added"
end
