;;;; just some code to manage multiple eshells

;; relies on the package 'perspective' from melpa

(defun persp-eshell--eshell-buffer-p (buffer)
  (string-prefix-p "*eshell*" (buffer-name buffer)))

(defun persp-eshell--persp-eshell ()
  (cl-find-if 'persp-eshell--eshell-buffer-p
              (persp-buffers (persp-curr))))

(defun persp-eshell--get-next-eshell-n ()
  (let ((n 0))
    (while (get-buffer (format "*eshell*<%i>" n))
      (cl-incf n))
    n))

;; bind this to a key of your choice
(defun persp-eshell--jump-to-perps-eshell ()
  (interactive)
  (let ((buff (persp-eshell--persp-eshell)))
    (if buff (switch-to-buffer-other-window buff)
      (eshell (persp-eshell--get-next-eshell-n)))))

