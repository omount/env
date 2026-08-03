# 进入gitlab容器
docker exec -it gitlab /bin/bash

# 重置gitlab密码
docker exec -it gitlab gitlab-rake "gitlab:password:reset[root]"

# 查看密码
docker exec -it gitlab cat /etc/gitlab/initial_root_password