/// ChatScreen interactivity scripts.
class ChatScripts {
  ChatScripts._();

  static const String code = r'''
  function bindChatScreens() {
    document.querySelectorAll('.arcane-chat-screen').forEach(function(chat) {
      if (chat.dataset.arcaneInteractive === 'true') return;
      chat.dataset.arcaneInteractive = 'true';

      var inputArea = chat.querySelector('.arcane-chat-input');
      var sendBtn = chat.querySelector('.arcane-chat-send');
      var messagesArea = chat.querySelector('.arcane-chat-messages');

      if (inputArea && sendBtn) {
        // Auto-resize textarea
        inputArea.addEventListener('input', function() {
          inputArea.style.height = 'auto';
          inputArea.style.height = Math.min(inputArea.scrollHeight, 120) + 'px';
        });

        // Send on enter (without shift)
        inputArea.addEventListener('keydown', function(e) {
          if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
          }
        });

        // Send button click
        sendBtn.addEventListener('click', function() {
          sendMessage();
        });
      }

      function sendMessage() {
        var text = inputArea.value.trim();
        if (!text) return;

        // Dispatch event for handling
        chat.dispatchEvent(new CustomEvent('sendmessage', {
          detail: { text: text }
        }));

        // Clear input
        inputArea.value = '';
        inputArea.style.height = 'auto';

        // Scroll to bottom
        if (messagesArea) {
          messagesArea.scrollTop = messagesArea.scrollHeight;
        }
      }

      // Auto-scroll when new messages arrive
      if (messagesArea) {
        var observer = new MutationObserver(function(mutations) {
          mutations.forEach(function(mutation) {
            if (mutation.addedNodes.length) {
              messagesArea.scrollTop = messagesArea.scrollHeight;
            }
          });
        });

        observer.observe(messagesArea, { childList: true });
      }
    });
  }
''';
}
