# pass a github username as the sole argument to the script
# for each of the user's repos, if a repo with the same name exists in the current directory, a pull will be done in the repo
# if a repo with the same name does not exist in the current directory, the repo will be cloned

start_dir=$(pwd)

gh repo list "$1" --json url,name --limit 10000 | jq -c '.[]' | while read -r obj; do
    name=$(echo "$obj" | jq -r '.name')
    url=$(echo "$obj" | jq -r '.url')

    if [ -d "$start_dir/$name/.git" ]; then
        cd "$start_dir/$name" && git pull
    else
        cd "$start_dir" && git clone "$url"
    fi
done
