package com.ez.gw.messagecontent.model;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessageContentServiceImpl implements MessageContentService{
	private final MessageContentDAO messageContentDao;
	
	@Override
	public int insertMessage(MessageContentVO vo) {
		return messageContentDao.insertMessage(vo);
	}

	@Override
	public List<Integer> selectAllReader(int empNo) {
		return messageContentDao.selectAllReader(empNo);
	}

	@Override
	public MessageViewVO selectLastMessageByReader(MessageViewVO mViewVo) {
		return messageContentDao.selectLastMessageByReader(mViewVo);
	}

	@Override
	public int updateReadDate(MessageViewVO vo) {
		return messageContentDao.updateReadDate(vo);
	}

	@Override
	public List<MessageViewVO> selectAllMyMessage(MessageViewVO mViewVo) {
		return messageContentDao.selectAllMyMessage(mViewVo);
	}

	@Override
	public List<MessageViewVO> selectLastMessage(int empNo) {
		return messageContentDao.selectLastMessage(empNo);
	}

	@Override
	public int updateDelFlagOrDelete(MessageViewVO vo) {
		int delCnt=messageContentDao.searchDeleteMessage(vo);
		int cnt=0;
		
		if(delCnt==0) {
			cnt=messageContentDao.deleteMessage(vo.getMessageNo());
		}else {
			cnt=messageContentDao.updateSendDelFlag(vo);
		}
		
		return cnt;
	}
	
	
}
