$hit = git rev-list --all | ForEach-Object {
  $c = $_
  git ls-tree -r --name-only $c |
    Where-Object { $_ -match 'mod_auth_openidc.*\.vcxproj$' } |
    ForEach-Object { [PSCustomObject]@{Commit=$c; Path=$_} }
} | Select-Object -First 1

$hit
if ($hit) {
  git restore --source=$($hit.Commit) -- $($hit.Path)
}