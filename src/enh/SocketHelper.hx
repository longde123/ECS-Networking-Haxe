package enh;

import enh.Builders;


class SocketHelper
{
	private var enh:Enh;

	public function new(enh)
	{
		this.enh = enh;
	}

	private function readSocket(conn:Connection)
	{
        conn.input.position = 0;

        while(conn.input.bytesAvailable > 2)
        {
            var msgLength = conn.input.readShort();
            // trace("msgLength " + msgLength);
            if(conn.input.bytesAvailable < msgLength) break;

            var msgPos = conn.input.position;
            while(conn.input.position - msgPos < msgLength)
            {
                enh.manager.processDatas(conn);
            }
        }

        if(conn.input.bytesAvailable == 0)
        {
            conn.input.clear();
        }

        conn.input.position = conn.input.length;
	}
}