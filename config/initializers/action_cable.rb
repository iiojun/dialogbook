module ActionCable
  module Connection
    class Base
      # デフォルトの3秒から1秒に短縮して、Apacheが切断する前にパケットを送りつける
      # (元の定数を上書きするため、警告が出ないように一度取り消してから再定義します)
      remove_const(:BEAT_INTERVAL) if defined?(BEAT_INTERVAL)
      BEAT_INTERVAL = 1.0
    end
  end
end
