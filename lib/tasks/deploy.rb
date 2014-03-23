# https://gist.github.com/jphenow/5694169
# https://gist.github.com/njvitto/362873
namespace :deploy do
  PRODUCTION_APP = ''

  task :set_production_app do
    raise "Production app variable not set!" if PRODUCTION_APP.blank?
    APP = PRODUCTION_APP
  end

  desc "Deploy to production"
  task :production => %W[deploy:set_production_app deploy:off deploy:push deploy:restart deploy:on deploy:tag]

  desc "Rollback production previous release"
  task :production_rollback => %W[deploy:set_production_app deploy:off deploy:push_previous deploy:restart deploy:on]

  task :push do
    git_status = `git status -v`
    abort("Local branch is out of sync with GitHub origin. Please push there first.") if git_status.match(/\*[^\]]+?\[ahead|behind/s) != nil
    current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
    current_branch += ":master" if current_branch != "master"
    puts "Deploying #{current_branch} to #{APP} ..."
    puts `git push -f git@heroku.com:#{APP}.git #{current_branch}`
  end

  task :restart do
    puts 'Restarting app servers ...'
    Bundler.with_clean_env do
      puts `heroku restart --app #{APP}`
    end
  end

  task :tag do
    release_name = "#{APP}-release-#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
    puts "Tagging release as '#{release_name}'"
    puts `git tag -a #{release_name} -m 'Tagged release'`
    puts `git push git@heroku.com:#{APP}.git #{release_name}`
    puts `git push --tags origin`
  end

  task :off do
    puts 'Putting the app into maintenance mode ...'
    Bundler.with_clean_env do
      puts `heroku maintenance:on --app #{APP}`
    end
  end

  task :on do
    puts 'Taking the app out of maintenance mode ...'
    Bundler.with_clean_env do
      puts `heroku maintenance:off --app #{APP}`
    end
  end

  task :push_previous do
    prefix = "#{APP}-release-"
    releases = `git tag`.split("\n").select { |t| t[0..prefix.length-1] == prefix }.sort
    current_release = releases.last
    previous_release = releases[-2] if releases.length >= 2
    if previous_release
      puts "Rolling back to '#{previous_release}' ..."

      puts "Checking out '#{previous_release}' in a new branch on local git repo ..."
      puts `git checkout #{previous_release}`
      puts `git checkout -b #{previous_release}`

      puts "Removing tagged version '#{previous_release}' (now transformed in branch) ..."
      puts `git tag -d #{previous_release}`
      puts `git push git@heroku.com:#{APP}.git :refs/tags/#{previous_release}`

      puts "Pushing '#{previous_release}' to Heroku master ..."
      puts `git push git@heroku.com:#{APP}.git +#{previous_release}:master --force`

      puts "Deleting rollbacked release '#{current_release}' ..."
      puts `git tag -d #{current_release}`
      puts `git push --delete origin #{current_release}`
      puts `git push git@heroku.com:#{APP}.git :refs/tags/#{current_release}`

      puts "Retagging release '#{previous_release}' in case to repeat this process (other rollbacks)..."
      puts `git tag -a #{previous_release} -m 'Tagged release'`
      puts `git push --tags git@heroku.com:#{APP}.git`

      puts "Turning local repo checked out on master ..."
      puts `git checkout master`
      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
      puts releases
    end
  end
end
