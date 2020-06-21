(defun init_rosemacs-install (distro)
  (interactive
   (list
    (read-string "Your ROS distribution: ")))
  (let ((default-directory "/sudo::"))
  (shell-command (format "apt-get -y install ros-%s-rosemacs" distro) "*install-result*"))
  )

(defun rosemacs_turnon (distro)
  (interactive
   (list
    (read-string "Your ROS distribution: ")))
  (add-to-list 'load-path (format "/opt/ros/%s/share/emacs/site-lisp" distro))
  (require 'rosemacs-config)
  )
