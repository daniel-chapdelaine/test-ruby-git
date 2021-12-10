class Chef

  # @repo < Git::Base

  def initialize
    set_repo
  end

  private

  def set_repo
    FileUtils.rm_rf('app/assets/git-clone')
    @git = Git.clone('https://github.com/daniel-chapdelaine/push-ruby-git', 'app/assets/git-clone', branch: 'master')
    @git.branch('new_branch').checkout
    # todo remove
    bump_recipe_version
    push_to_origin
  end

  def bump_recipe_version
    path = File.expand_path('../assets/git-clone/vendor/cookbooks/ssh/metadata.rb', __dir__)
    metadata = File.readlines(path)
    version_line_index = metadata.index { |line| line =~ /version/ }
    current_version = metadata[version_line_index][/\d+\.\d+\.\d+/]
    version_parts = current_version.split('.').map(&:to_i)
    version_parts[-1] += 1
    bumped = version_parts.join('.')
    metadata[version_line_index].gsub!(current_version, bumped)
    File.write(path, metadata.join)
  end

  def push_to_origin
    @git.add(all: true)
    @git.commit('some awesome changes were made')
    @git.push('origin', 'new_branch')
  end

end
