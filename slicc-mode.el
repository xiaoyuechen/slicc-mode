;;; slicc-mode.el --- Major mode for gem5 SLICC files -*- lexical-binding: t; -*-

;; Author: Xiaoyue Chen <xchen@vvvu.org>
;; URL: https://github.com/xiaoyuechen/slicc-mode
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1"))
;; Keywords: languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Major mode for gem5 SLICC (.sm) coherence-protocol files.
;;
;; Derived from `c-mode' so that indentation, brace/paren matching,
;; and comment/string handling come for free, with SLICC-specific
;; font-lock rules layered on top for its keywords, types, and the
;; ALL_CAPS convention SLICC protocols use for states and events.

;;; Code:

(require 'cc-mode)

(defvar slicc-keywords
  '("machine" "MachineType" "in_port" "out_port" "action" "transition"
    "structure" "enumeration" "external_type" "message_type"
    "peek" "enqueue" "dequeue" "pop" "trigger"
    "wake_up_dependents" "wake_up_buffers" "stall_and_wait"
    "check_allocate" "check_on_cache_probe" "check_stop_slots"
    "state_declaration" "include" "APPEND_TRANSITION_COMMENT"
    "DPRINTF" "DEBUG_EXPR" "profile_request")
  "SLICC-specific keywords not already handled by `c-mode'.")

(defvar slicc-types
  '("void" "int" "bool" "string" "Addr" "Cycles" "MachineID" "NodeID"
    "Entry" "TBE" "TBETable" "Time" "Set" "NetDest" "MessageBuffer"
    "CacheMemory" "DirectoryMemory" "MemoryControl" "Sequencer"
    "RubyRequestType" "AccessPermission" "DataBlock")
  "Common SLICC/Ruby types.")

(defvar slicc-builtin-functions
  '("is_valid" "is_invalid" "getAddressBits" "getOffset" "makeLineAddress"
    "testAndRead" "testAndWrite" "functionalRead" "functionalWrite")
  "Common SLICC builtin functions.")

(defvar slicc-font-lock-keywords
  `((,(regexp-opt slicc-keywords 'words) 0 font-lock-keyword-face t)
    (,(regexp-opt slicc-types 'words) 0 font-lock-type-face t)
    (,(regexp-opt slicc-builtin-functions 'words) 0 font-lock-builtin-face t)
    ;; action(a_name, ...) / transition(...) block names
    ("\\_<\\(action\\|transition\\)\\_>\\s-*(\\s-*\\([A-Za-z_][A-Za-z0-9_]*\\)"
     2 font-lock-function-name-face)
    ;; ALL_CAPS tokens: SLICC convention for states/events (GETX, M, IM_AD, ...)
    ("\\_<[A-Z][A-Z0-9_]*\\_>" . font-lock-constant-face)
    ;; Type:Field qualifiers, e.g. CacheEntry:Entry, MachineType:L1Cache
    ("\\_<\\([A-Za-z_][A-Za-z0-9_]*\\):\\([A-Za-z_][A-Za-z0-9_]*\\)\\_>"
     (1 font-lock-type-face) (2 font-lock-type-face)))
  "Font-lock keywords for `slicc-mode', layered on top of `c-mode'.")

;;;###autoload
(define-derived-mode slicc-mode c-mode "SLICC"
  "Major mode for editing gem5 SLICC protocol (.sm) files."
  (font-lock-add-keywords nil slicc-font-lock-keywords 'end)
  (modify-syntax-entry ?_ "w" slicc-mode-syntax-table))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.sm\\'" . slicc-mode))

(provide 'slicc-mode)
;;; slicc-mode.el ends here
