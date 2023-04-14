(require 'cl-lib)

(defun count-words-in-file (filename)
  "Count the number of words in a file and return the count."
  (with-temp-buffer
	(insert-file-contents filename)
	(let*
		((word-count (count-words (point-min) (point-max)))
		 (line-count (count-lines (point-min) (point-max))))
	  (cl-values word-count line-count))))

(defun count-words-in-folder (folder)
  "Count the number of words in all text files in a folder and output the results to a CSV file."
  (let* ((file-list (directory-files-recursively folder ".*\.java$"))
		 (output-file "C:\\Users\\egugwen\\dj\\emacs-config\\word-line-count.csv"))
	(with-temp-file output-file
	  (insert "Filename,Word Count,Line Count\n"))
	(dolist (file file-list)
	  (setq word-line-count (count-words-in-file file))
	  (let* ((filename (file-name-nondirectory file))
			 (output-line (concat filename "," (number-to-string (pop word-line-count)) "," (number-to-string (pop word-line-count)) "\n")))
		(with-temp-file output-file
		  (insert-file-contents output-file)
		  (goto-char (point-max))
		  (insert output-line))))))

(count-words-in-folder "C:\\Users\\egugwen\\dj\\testng")
